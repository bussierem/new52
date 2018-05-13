import pika
import pika
import sys
import uuid

from enum import Enum
from typing import Callable

class ExchangeType(Enum):
  FANOUT = 'fanout'
  DIRECT = 'direct'
  TOPIC = 'topic'

class MessageProducer:
  """
    Initializes the Producer object with barebones setup

    @param mq_host: hostname of the RabbitMQ Server

    @return: N/A
  """
  def __init__(self, mq_host:str, queue:str='', exchange:str='', ex_type:ExchangeType=ExchangeType.DIRECT, blocking:bool=False):
    self.connection = pika.BlockingConnection(pika.ConnectionParameters(host='localhost'))
    self.channel = connection.channel()
    self.ex_name = exchange
    self.q_name = queue
    if blocking:
      self.channel.basic_qos(prefetch_count=1)
    if queue != '':
      self.channel.queue_declare(queue=queue)
    if exchange != '':
      self.channel.exchange_declare(exchange=exchange, exchange_type=ex_type)

  """
    Send Message through the queue, exchange, etc

    @param message: The message to be sent
    @param routing_key: Routing Key (defaults to queue name)
    @param properties: The named params to be used for pika.BasicProperties object init

    @return: N/A
  """
  def send(self, message:str, routing_key:str=None, properties:dict=None):
    if routing_key == None:
      routing_key = self.q_name
    props = None if properties == None else pika.BasicProperties(**properties)
    self.channel.basic_publish(exchange=self.ex_name, routing_key=self.q_name, body=message, properties=props)
