import os
from datetime import datetime
from kittens.tui.handler import result_handler

def main(args):
    pass

@result_handler(no_ui=True)
def handle_result(args, result, target_window_id, boss):
    for i in range(int(args[1])):
        boss.move_tab_backward()

