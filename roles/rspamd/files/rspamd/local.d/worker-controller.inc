# generate a password hash using the `rspamadm pw` command and define 'password'
# this one is the hash for 'hunter2'
# password = "$2$b9s94udsn7zzgk1hc9wuheqqcpydo64x$a1kksr9r9f1g1358shqdz789wmoqbnapndwqi6uscazhz3muz4gy";

# this one is the hash for:
# Roberts had grown so rich, he wanted to retire. He took me to his cabin and he told me his secret. 'I am not the Dread Pirate Roberts' he said. 'My name is Ryan; I inherited the ship from the previous Dread Pirate Roberts, just as you will inherit it from me. The man I inherited it from is not the real Dread Pirate Roberts either. His name was Cummerbund. The real Roberts has been retired 15 years and living like a king in Patagonia.'
# password = "$2$bhjy5j4njn8r5mx3yo6ksmdt9hbm8fan$myysr1gnbcf9ggpf4dzjdky3by9nbb8w9wbm7wciu97sbb7zhomy";

# this one is the hash for:
# The point is, ladies and gentleman, that greed, for lack of a better word, is good. Greed is right, greed works. Greed clarifies, cuts through, and captures the essence of the evolutionary spirit. Greed, in all of its forms; greed for life, for money, for love, knowledge has marked the upward surge of mankind. And greed, you mark my words, will not only save Teldar Paper, but that other malfunctioning corporation called the USA. Thank you very much.
# password = "$2$eqre5picpektnop85uashzyxpxeeo6cr$gugecdr35jhg8uhzxkwh4jnp19rtxc6ukaadaad5665sm1rapmfy";

# this one is the hash for:
# whence the day goes on
# password = "$2$am4gzwgxbuksntkn7784g6mpoir4mp1o$83i86hfju6jfbp6g9w9sh44qacqmne85q9weah6xcj1d3c5ei1rb";


# You can list multiple bind sockets on networks and file systems.
#bind_socket = "/var/run/rspamd/rspamd.sock mode=0666 owner=nobody";

# The worker controller handles multiple functions:
# - trains spam
# - trains not-spam
# - hosts the built-in statistics web interface
# - web interface also allows config modification and data injection

# The config parameter 'secure_ip' defines which sources DO NOT need a
# password to connect to this worker controller.
# By default, 'secure_ip' is defined as:
# secure_ip = "127.0.0.1";
# secure_ip = "::1";
#
# If you need distributed rspamd access or want to view your spam stats console
# from another machine without SSH tunneling port 11334, you can add multiple
# non-localhost IP address config lines here, but also remember to
# define 'password' above as well.

bind_socket = "127.0.0.1:11334";
#bind_socket = "192.168.122.8:11334";
