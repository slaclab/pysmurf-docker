#!/usr/bin/env ipython3

import os
import numpy as np
import matplotlib.pyplot as plt
import pysmurf

# The epics prefix is defined in the environmental variable 'EPICS_PREFIX'
epics_prefix = os.getenv('EPICS_PREFIX')
