from dataclasses import dataclass
from typing import Dict, List, Union

import yaml

BASE_KEY = "base"


@dataclass
class Config:
    name: str
    add: bool
    path: str
    stow: str


def config_for_name(name: str, configs: List[Config]) -> Union[Config, None]:
    _configs = [config for config in configs if config.name == name]
    assert len(_configs) <= 1, f"Multiple configs found for {name}. {configs}"

    if _configs:
        return _configs[0]

    return None


def replace(name: str, data: Dict, configs: List[Config]):
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
               base_group: List[Config] = None) -> List[Config]:
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
            results.append(Config(name=name, **conf[name]))
        except TypeError as error:
            print("base_group:", base_group)
            print("data:", conf)
            raise error

    return results


def print_output(configs: List[Config]):
    """Prints out config strings intended for further bash processing.

    Parameters
    ----------
    configs : List[Config]
       Final config list.
    """
    ...


def main():
    """main.
    """

    # TODO get other conf groups (like mac, etc.) as argument

    with open("./base.yml", "r") as file:
        doc: Dict = yaml.load(file, yaml.FullLoader)

    assert BASE_KEY in doc, "Config 'base' has to be in config file."
    print(doc)
    base_confs = to_configs(doc.pop(BASE_KEY))
    assert all(conf.add
               for conf in base_confs), "All base configs must have add: True"

    other_config_groups = [
        to_configs(group, base_confs) for config, group in doc.items()
    ]
    print(base_confs)
    print(other_config_groups)


if __name__ == "__main__":
    main()
