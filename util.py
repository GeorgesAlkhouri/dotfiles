"""Small utility script to generate stow configs more comfortable."""
from dataclasses import dataclass
from typing import Any, Dict, List, Union

import click
import yaml


@dataclass(frozen=True)
class StowConfig:
    """Represantation of a stow configuration.
    path: path where the dotfile (or anything else) should be stowed
    stow: folder which contains the  files to be stowed
    add: remove or add stow config from the configuration group
    name: name of the stow config
    """

    name: str
    add: bool
    path: str
    stow: str

    def __eq__(self, o) -> bool:
        return o.name == self.name and o.path == self.path and o.stow == self.stow

    def __hash__(self) -> int:
        return hash((self.name, self.path, self.stow))


def config_for_name(name: str,
                    configs: List[StowConfig]) -> Union[StowConfig, None]:
    """Returns stow config for a name. Raises an exception when multiple configs
    are found with the same name.

    Returns
    -------
    Union[StowConfig, None]

    """
    _configs = [config for config in configs if config.name == name]
    assert len(_configs) <= 1, f"Multiple configs found for {name}. {configs}"

    if _configs:
        return _configs[0]

    return None


def replace(name: str, data: Dict, configs: List[StowConfig]):
    """Looks in list of existing configs (mostly base config group)
    and replaces non existing parts in the data dict.

    Parameters
    ----------
    name : str
       Name of a config.
    data : Dict
        Data of a config.
    configs : List[Config]
       Config group to look into for replacing.
    """
    config = config_for_name(name, configs)
    conf_data = data[name]
    if config:
        if "add" not in conf_data:
            conf_data["add"] = config.add
        if "path" not in conf_data:
            conf_data["path"] = config.path
        if "stow" not in conf_data:
            conf_data["stow"] = config.stow


def to_configs(configs: List[Dict],
               base_group: List[StowConfig] = None) -> List[StowConfig]:
    """Converts a config group from dict (from yaml file) into
    a list of Configs. If base_group is provided try to 'inherit' missing
    fields from dict.

    Parameters
    ----------
    configs : List[Dict]
        configs
    base_group : List[Config]
        base_group

    Returns
    -------
    List[Config]

    """

    results = []
    for conf in configs:
        name = list(conf.keys())[0]
        if base_group:
            replace(name, conf, base_group)

        try:
            results.append(StowConfig(name=name, **conf[name]))
        except TypeError as error:
            print("base_group:", base_group)
            print("data:", conf)
            raise error

    return results


def print_output(configs: List[StowConfig], sep=";"):
    """Prints out config strings intended for further bash processing.

    Parameters
    ----------
    configs : List[Config]
       Final config list.
    """
    for config in configs:

        config_line = f"\"{config.path}{sep}{config.stow}\""
        print(config_line)


def resolve(base_group: List[StowConfig],
            other_group: List[StowConfig]) -> List[StowConfig]:
    """Removes configurations tagged with add=False in other_group
    and adds configurations respectively.
    """
    assert all(conf.add
               for conf in base_group), "All base configs must have add: True"

    remove_confs = [conf for conf in other_group if not conf.add]
    add_confs = [conf for conf in other_group if conf.add]

    result_confs: Any = set(base_group).difference(remove_confs).union(
        add_confs)
    result_confs = sorted(result_confs, key=lambda c: c.name)
    return result_confs


def assert_group_name(name: str, doc: Dict):
    assert name in doc, f"Configuration group '{name}' not in config file."


@click.command()
@click.argument("path", type=click.Path(exists=True, dir_okay=False))
@click.option("-b",
              "--base",
              type=str,
              default="base",
              show_default=True,
              help="Name of the base configuration group in the config file.")
@click.option(
    "-g",
    "--group",
    type=str,
    default=None,
    help="Name of an additional configuration group in the config file.")
def run(**kwargs):
    """Reads the given YAML config file and extracts configuration groups to create
    a bash friendly list of stow configs.
    A base configuration group (CG) is mandetory (Default: 'base').
    An addidtional CG can be specified. In the additional CG youcan deselect
    or override configs written in the base CG. The script prints out one
    line for each config in the following format: \"Path;Stow\".
    E.g. \"$HOME/.config/nvim;nvim\"
    """

    with open(kwargs["path"], "r") as file:
        doc: Dict = yaml.load(file, yaml.FullLoader)

    assert_group_name(BASE_KEY, doc)
    base_confs = to_configs(doc.pop(BASE_KEY))

    result_group = base_confs
    if kwargs["group"]:
        group_name = kwargs["group"]
        assert_group_name(group_name, doc)
        other_group = to_configs(doc.pop(group_name), base_group=base_confs)
        result_group = resolve(base_confs, other_group)

    print_output(result_group)


if __name__ == "__main__":
    run()
