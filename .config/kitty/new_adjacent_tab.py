import subprocess
import os
from kittens.tui.handler import result_handler

def main(args):
    # o = subprocess.run([f"{os.environ["HOME"]}/.cargo/bin/kittles", "--adjacent"], capture_output=True)
    # print(o)
    # print("hi")
    # o = subprocess.run(["kitty", "@", "launch"])

    # o = subprocess.run(["kittles"])
    print(os.environ)
    o = subprocess.run([f"{os.environ["HOME"]}/.cargo/bin/kittles"], capture_output=True)
    print(o)
    input()
    pass

@result_handler(no_ui=False)
def handle_result(args, result, target_window_id, boss):
    print('sub')

