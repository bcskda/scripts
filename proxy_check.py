import time
import os
import requests
import socket
from sched import scheduler


ENCODING = 'utf-8'
INTERVAL_SEC = 60

def check_status_code(url, proxy) -> bool:
    code = 0
    try:
        resp = requests.head(url, proxies={"https": proxy})
        code = resp.status_code
    except Exception as e:
        pass
    return code

def write_graphite(graphite_addr, key, value, ts=None):
    if ' ' in key:
        raise ValueError("Space in metric name")
    if ts is None:
        ts = int(time.time())
    mesg = ' '.join(map(str, (key, value, ts))) + '\n'
    print(mesg)
    with socket.create_connection(graphite_addr) as sock:
        sock.sendall(mesg.encode(ENCODING))
        sock.shutdown(socket.SHUT_RDWR)

def get_args():
    env_keys = [
        "https_proxy", "https_target", "metric_key", "graphite_host",
        "graphite_port"
    ]
    env_values = tuple(map(os.getenv, env_keys))
    if not all(env_values):
        raise ValueError(f"one or more environment variables missing: {env_keys}")
    return env_values

def report_single(proxy, target, metric, graphite_addr):
    value = check_status_code(target, proxy)
    write_graphite(graphite_addr, metric, value)

def main():
    proxy, target, metric, host, port = get_args()
    graphite_addr = (host, port)
    sched = scheduler()
    while True:
        try:
            sched.enter(INTERVAL_SEC, 1, report_single,
                argument=(proxy, target, metric, graphite_addr))
            sched.run()
        except KeyboardInterrupt:
            break

if __name__ == "__main__":
    main()
