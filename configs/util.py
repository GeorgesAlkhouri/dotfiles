from dataclasses import dataclass
from typing import Dict, List

import yaml

BASE_KEY = "base"


@dataclass
class Config:
    name: str
    add: bool
    path: str
    stow: str


def to_configs(configs: List[Dict]) -> List[Config]:

    results = []
    for conf in configs:
        name = list(conf.keys())[0]
        results.append(Config(name=name, **conf[name]))
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
    base_confs = to_configs(doc.pop(BASE_KEY))
    assert all(conf.add
               for conf in base_confs), "All base configs must have add: True"


if __name__ == "__main__":
    main()
