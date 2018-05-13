import pika
import sys

connection = pika.BlockingConnection(pika.ConnectionParameters(host='localhost'))
channel = connection.channel()
# declare a "direct" exchange
# Only sends messages to queues whose "binding_key" matches the message's "routing_key" EXACTLY
channel.exchange_declare(exchange='direct_logs', exchange_type='direct')

severity = sys.argv[1] if len(sys.argv) > 2 else 'info'
message = ' '.join(sys.argv[2:]) or 'Hello World!'

# Publish the method with the provided (or default) severity as a "routing_key"
channel.basic_publish(exchange='direct_logs', routing_key=severity, body=message)
print(" [x] Sent [{}]: {}".format(severity.upper(), message))

connection.close()
