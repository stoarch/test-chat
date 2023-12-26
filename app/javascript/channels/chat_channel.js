import consumer from "channels/consumer"

consumer.subscriptions.create({ channel: "ChatChannel", chat_id: 1 }, {
  received(data) {
    const currentUserId = document.body.getAttribute('data-user-id');
    if(currentUserId !== data.user.toString()){
      const messages = document.getElementById('messages');
      messages.innerHTML += data.message.length + "> " + data.message;
    }

    console.log("Message:",data, data.message);
  }
});