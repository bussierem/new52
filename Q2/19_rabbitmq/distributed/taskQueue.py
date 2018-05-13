import sys
import pika

QUEUE_NAME = 'task_queue'

# connect to the localhost and get the channel
connection = pika.BlockingConnection(pika.ConnectionParameters('localhost'))
channel = connection.channel()

# declare the queue, name it
channel.queue_declare(queue=QUEUE_NAME, durable=True) # Durable means the queue isn't forgotten

# Build a message
message = ' '.join(sys.argv[1:]) or "Hello World!"
channel.basic_publish(exchange='', routing_key='hello', body=message,
                      properties=pika.BasicProperties(
                        delivery_mode=2 # make message persistent
                      ))
print(" [x] Sent {}".format(message))

# clean up after ourselves
connection.close()
