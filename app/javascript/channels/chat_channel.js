import consumer from "channels/consumer"

consumer.subscriptions.create({ channel: "ChatChannel", chat_id: 1 }, {
  received(data) {
    const currentUserId = document.body.getAttribute('data-user-id');

    console.log("Message:",data, data.message);
    if(currentUserId !== data.user.toString()){
      const messages = document.getElementById('messages');
      messages.innerHTML += data.message.length + "> " + data.message;

      // Show the tooltip
      const tooltip = document.getElementById('message-tooltip');
      tooltip.innerHTML = data.message;
      tooltip.style.display = 'block';
      
      // Play the sound
      const sound = document.getElementById('message-sound');
      sound.play();

      // Optionally, hide the tooltip after a few seconds
      setTimeout(() => {
        tooltip.style.display = 'none';
      }, 5000);
    }
  }
});