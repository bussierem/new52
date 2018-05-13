import pika

connection = pika.BlockingConnection(pika.ConnectionParameters(host='localhost'))
channel = connection.channel()

# Declare an exchange named "logs" that sends msgs to ALL QUEUES
channel.exchange_declare(exchange='logs', exchange_type='fanout')
# Declare a _randomly named_ queue by not declaring any name
result = channel.queue_declare(exclusive=True) # "exclusive" closes the queue when there are no consumers left
queue_name = result.method.queue
# Tell the channel to send messages to our new queue
channel.queue_bind(exchange='logs', queue=queue_name)

print("[*] Waiting for logs.  To exit press CTRL+C")

def callback(ch, method, properties, body):
  print(" [x] %r" % body)

channel.basic_consume(callback, queue=queue_name, no_ack=True)

channel.start_consuming()
