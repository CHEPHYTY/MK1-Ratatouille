import requests
import time

def check_internet(url='http://www.google.com/', timeout=5):
    """
    Check if internet is available by sending a request to a specific URL.
    """
    try:
        response = requests.get(url, timeout=timeout)
        return True
    except (requests.ConnectionError, requests.Timeout):
        return False

def perform_tasks():
    """
    Function to perform tasks after internet is available.
    """
    print("Internet is available, performing tasks...")
    # Add the tasks you want to perform here
    # For example, downloading a file, sending an email, etc.
    # Example:
    # response = requests.get('http://example.com/somefile')
    # with open('somefile', 'wb') as file:
    #     file.write(response.content)
    print("Tasks completed.")

def wait_for_internet():
    """
    Continuously check for internet connectivity and perform tasks when available.
    """
    print("Waiting for internet connection...")
    while not check_internet():
        time.sleep(5)
    perform_tasks()

if __name__ == "__main__":
    wait_for_internet()
