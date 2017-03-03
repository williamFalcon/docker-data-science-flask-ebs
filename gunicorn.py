from multiprocessing import cpu_count


def max_workers():
    return cpu_count()

bind = '0.0.0.0:5000'
workers = max_workers()
