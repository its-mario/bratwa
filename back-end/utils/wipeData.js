const StreamChat = require('stream-chat').StreamChat;


const client = StreamChat.getInstance('b9kb7e5cs576','e5466gknvppt2pg3r4ar3tvpcbygpn3n7xxnmmns6vn5heynvhgsy8af4pudw68u'); 

const filter = {type: 'messaging', members: { $in: ['thierry'] } };
const sort = [{ last_message_at: -1 }]; 



client.queryChannels(filter, sort,{
    watch: true,
    state: true,
}).then(async(channels) => {
    for (const c of channels){
        console.log(c.custom.name, c.cid); 
    }
} );

