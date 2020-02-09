import os
import requests


def is_reachable(url, proxy) -> bool:
    success = False
    try:
        resp = requests.head(url, proxies={"https": proxy})
        success = resp.status_code == requests.status_codes.ok
    except Exception as e:
        print(e)
    return success

def main():
    proxy = os.getenv("https_proxy")
    target = os.getenv("https_target")
    if not all((proxy, target)):
        print("one or more environment variables missing: https_proxy, https_target")
        return
    
    if is_reachable(target, proxy):
        print("OK")
    else:
        print("Error")

if __name__ == "__main__":
    main()
