import functions_framework
import google.cloud.logging
import logging
import random
import time

def resolve_req(action, request):
    """HTTP Cloud Function.
    Args:
        action: the action to log.
        request (flask.Request): The request object.
        <https://flask.palletsprojects.com/en/1.1.x/api/#incoming-request-data>
    Returns:
        The response text, or any set of values that can be turned into a
        Response object using `make_response`
        <https://flask.palletsprojects.com/en/1.1.x/api/#flask.make_response>.
    """
    logging.info(f"action:{action} | result:in_progress")
    request_json = request.get_json(silent=True)
    request_args = request.args

    if request_json and "value" in request_json:
        value = request_json["value"]
    elif request_args and "value" in request_args:
        value = request_args["value"]
    else:
        logging.info(f"action:processing | result:in_progress")
        to_sleep = random.uniform(0, 2)
        time.sleep(to_sleep)
        logging.info(f"action:processing | result:success | elapsed:{to_sleep}")
        value = f"data1,data2,data3,{random.randint(0,10000)}"
    time.sleep(random.uniform(0, 1))
    logging.info(f"action:{action} | result:success | value:{value}")
    return "OK", 200

@functions_framework.http
def boundary1(request):
    return resolve_req("boundary1", request)

@functions_framework.http
def boundary2(request):
    return resolve_req("boundary2", request)

def cloud_init():
    client = google.cloud.logging.Client()
    client.setup_logging()

cloud_init()
