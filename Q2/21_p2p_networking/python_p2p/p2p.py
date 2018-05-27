import uuid
import json

from twisted.internet.endpoints import TCP4ServerEndpoint, TCP4ClientEndpoint, connectProtocol
from twisted.internet.protocol import Protocol, Factory
from twisted.internet import reactor

generate_nodeid = lambda: str(uuid4())

class MyProtocol(Protocol):
  def __init__(self, factory):
    self.factory = factory
    self.state = "HELLO"
    self.remote_nodeid = None
    self.nodeid = self.factory.nodeid

  def connectionMade(self):
    print("Connection from {}".format(self.transport.getPeer()))

  def connectionLost(self, reason):
    if self.remote_nodeid in self.factory.peers:
      self.factory.peers.pop(self.remote_nodeid)
    print("{} disconnected".format(self.nodeid))

  def dataReceived(self, data):
    for line in data.splitlines():
      line = line.strip()
      if self.state == "HELLO":
        self.handle_hello(line)
        self.state = "READY"

  def send_hello(self):
    hello = json.puts({ 'nodeid': self.nodeid, 'msgtype': 'hello' })
    self.transport.write(hello + '\n')

  def handle_hello(self, hello):
    hello = json.loads(hello)
    self.remote_nodeid = hello['nodeid']
    if self.remote_nodeid == self.nodeid:
      print("Connected to myself")
      self.transport.loseConnection()
    else:
      self.factory.peers[self.remote_nodeid] = self

class MyFactory(Factory):
  def startFactory(self):
    self.peers = {}
    self.nodeid = generate_nodeid()

  def buildProtocol(self, addr):
    return NCProtocol(self)

endpoint = TCP4ServerEndpoint(reactor, 5999)
endpoint.listen(MyFactory())
