import pika

# connect to the localhost and get the channel
connection = pika.BlockingConnection(pika.ConnectionParameters(host='localhost'))
channel = connection.channel()

# declare the queue, name it
channel.queue_declare(queue='hello')

# Declare a callback function for the queue
def callback(ch, method, properties, body):
  print(" [x] Received %r" % body)

# Assign the callback function to a specific queue
channel.basic_consume(callback, queue='hello', no_ack=True)

print(' [*] Waiting for messages. To exit press CTRL+C')
channel.start_consuming() # this infinitely loops
