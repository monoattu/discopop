import os
from typing import List

import jsons
import pytermgui as ptg

from discopop_wizard.classes.ExecutionConfiguration import ExecutionConfiguration
from discopop_wizard.screens.utils import exit_program


def push_add_configuration_screen(manager: ptg.WindowManager, config_dir: str, wizard):
    body = (
        ptg.Window(
            "",
            "Create a new execution configuration",
            "",
            ptg.InputField("<text>", prompt="Label: "),
            ptg.InputField("<text>", prompt="Description: "),
            ptg.InputField("<text>", prompt="Executable name: "),
            ptg.InputField("<text>", prompt="Executable arguments: "),
            ptg.InputField("<int>", prompt="Available threads: "),
            ptg.InputField("<path>", prompt="Project base path: "),
            ptg.InputField("<path>", prompt="Project source path: "),
            ptg.InputField("<path>", prompt="Project build path: "),
            ptg.InputField("<text>", prompt="Project configure options: "),
            ptg.InputField("<text>", prompt="Project linker flags: "),
            ptg.Container(
                "Additional notes:",
                ptg.InputField(
                    "<text>", multiline=True
                ),
                box="EMPTY_VERTICAL",
            ),
            box="DOUBLE",
        )
        .set_title("[210 bold]Create execution configuration")
    )
    manager.add(body, assign="body")
    wizard.push_body_window(body)

    buttons = (ptg.Window(
        ["Save", lambda *_: save_configuration(manager, body, config_dir, wizard)],
    ))
    manager.add(buttons, assign="body_buttons")
    wizard.push_body_buttons(buttons)


def save_configuration(manager: ptg.WindowManager, window: ptg.Window, config_dir: str, wizard):
    # TODO: overwrite run_configurations.txt
    execution_configs: List[ExecutionConfiguration] = []
    values = dict()
    for widget in window:
        if isinstance(widget, ptg.InputField):
            values[widget.prompt] = widget.value
            continue

        if isinstance(widget, ptg.Container):
            label, field = iter(widget)
            values[label.value] = field.value
    new_config = ExecutionConfiguration()
    new_config.init_from_values(values)
    execution_configs.append(new_config)
    # load old configs
    with open(os.path.join(config_dir, "run_configurations.txt"), "r") as f:
        file_contents = f.read()
    loaded_dicts: List[dict] = []
    if len(file_contents) > 0:
        loaded_dicts = jsons.loads(file_contents)
    for config in loaded_dicts:
        exec_config = ExecutionConfiguration()
        exec_config.init_from_dict(config)
        execution_configs.append(exec_config)
    # overwrite configs file
    json_dump_str = jsons.dumps(execution_configs)

    if not os.path.isfile(os.path.join(config_dir, "run_configurations.txt")):
        raise ValueError(os.path.join(config_dir, "run_configurations.txt"))
    os.remove(os.path.join(config_dir, "run_configurations.txt"))
    with open(os.path.join(config_dir, "run_configurations.txt"), "w+") as f:
        f.write(json_dump_str)
    # restart Wizard to load new execution configurations
    manager.stop()
    wizard.clear_window_stacks()
    wizard.initialize_screen(config_dir)


def submit(manager: ptg.WindowManager, window: ptg.Window, values: dict) -> None:
    for widget in window:
        if isinstance(widget, ptg.InputField):
            values[widget.prompt] = widget.value
            continue

        if isinstance(widget, ptg.Container):
            label, field = iter(widget)
            values[label.value] = field.value
    manager.stop()

