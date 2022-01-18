import time
import wandb
from call_back import *


def get(x):
    print(get_x(x))


if __name__ == '__main__':
    b = time.time()
    print('tim %d' % (time.time() - b))
    get(2)
    wandb.init(project='111')
    for i in range(100):
        wandb.log()
