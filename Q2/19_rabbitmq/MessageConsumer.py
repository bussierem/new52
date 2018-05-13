import pika
import sys
import uuid

from enum import Enum
from typing import Callable

class ExchangeType(Enum):
  FANOUT = 'fanout'
  DIRECT = 'direct'
  TOPIC = 'topic'

class MessageConsumer:
  """
    Initializes the Consumer object with barebones setup - no Queue, no Exchange, no Callback, etc.
    DOES NOT START THE CONSUMER!

    @param mq_host: hostname of the RabbitMQ Server

    @return: N/A
  """
  def __init__(self, mq_host:str, blocking:bool=False):
    self.connection = pika.BlockingConnection(pika.ConnectionParameters(host='localhost'))
    self.channel = connection.channel()
    if blocking:
      self.channel.basic_qos(prefetch_count=1)

  """
    Declares a new Exchange to be used by the Consumer to decide how to handle messages

    @param name: Name of the Exchange
    @param type: Type of the Exchange, as an ExchangeType value

    @return: N/A
  """
  def init_exchange(self, name:str, type:ExchangeType=ExchangeType.DIRECT):
    self.exchange_name = name
    self.channel.exchange_declare(exchange=name, exchange_type=type)

  """
    Declares a new Queue to be used by RabbitMQ

    @param name: Name of the Queue
    @param durable: Whether the Queue persists with a server restart
    @param exclusive: whether the Queue destructs when there are no available consumers for it
    @param key: Dot-notated routing key, with wildcards * (match single word) and # (match 1+ words)

    @return: N/A
  """
  def init_queue(self, name:str, durable:bool=False, exclusive:bool=False, key:str=None):
    tmp = self.channel.queue_declare(queue=name, durable=durable, exclusive=exclusive)
    self.queue_name = tmp.method.queue
    channel.queue_bind(exchange=self.exchange_name, queue=self.queue_name, routing_key=key)

  """
    Defines a callback function for the Consumer

    @param cb: Callback function with pika-defined prototype to handle incoming messages
    @return: N/A
  """
  def set_callback(self, cb:Callable[[str, pika.Method, pika.BasicProperties, str], None]):
    self.cb_func = cb

  """
    Start the Consumer and begin listening to messages

    @param acknowledge: Whether or not to acknowledge receipt of messages
    @param verbose:  Whether to print a message saying the Consumer has started up

    @return: N/A
  """
  def start(self, acknowledge:bool=False, verbose:bool=False):
    if self.queue_name == None:
      print("[ERROR] Queue was not declared first!  Consumer not started.")
      return
    if self.cb_func == None:
      print("[ERROR] Callback function was not declared first!  Consumer not started.")
      return
    self.channel.basic_
    self.channel.basic_consume(consumer_callback=self.cb_func, queue=self.queue_name, no_ack=!acknowledge)
    if verbose:
      print(' [*] Waiting for messages. To exit press CTRL+C')
    try:
      self.channel.start_consuming() # this infinitely loops
    except KeyboardInterrupt:
      self.channel.stop_consuming() # close connection safely
    self.connection.close()

  """
    Closes the Consumer's connection

    @return: N/A
  """
  def stop(self):
    self.channel.stop_consuming()
    self.connection.close()
