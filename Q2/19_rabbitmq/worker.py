import pika
import time

QUEUE_NAME = 'task_queue'

# connect to the localhost and get the channel
connection = pika.BlockingConnection(pika.ConnectionParameters(host='localhost'))
channel = connection.channel()

# declare the queue, name it
channel.queue_declare(queue=QUEUE_NAME, durable=True)

# Declare a callback function for the queue
def callback(ch, method, properties, body):
    print(" [x] Received {}".format(body))
    time.sleep(len(body))
    print(" [x] Done")
    # Send an acknowledgement of the delivery
    ch.basic_ack(delivery_tag = method.delivery_tag)

# Make sure that workers don't get assigned tasks until they complete the current one
channel.basic_qos(prefetch_count=1)
# Assign the callback function to a specific queue
channel.basic_consume(callback, queue=QUEUE_NAME)

print(' [*] Waiting for messages. To exit press CTRL+C')
channel.start_consuming() # this infinitely loops
