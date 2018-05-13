import pika

# connect to the localhost and get the channel
connection = pika.BlockingConnection(pika.ConnectionParameters('localhost'))
channel = connection.channel()

# declare the queue, name it
channel.queue_declare(queue='hello')

# Publish a message to the queue, default exchange
channel.basic_publish(exchange='', routing_key='hello', body='Hello World!')
print(" [x] Sent 'Hello World!'")

# clean up after ourselves
connection.close()
