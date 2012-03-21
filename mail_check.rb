require 'net/imap'
def check_mail name, server_conf, method, login, password, folder
  imap = Net::IMAP.new *server_conf
  if method == 'LOGIN'
    imap.login login, password
  else
    imap.authenticate method, login, password
  end
  imap.examine folder
  r = imap.search([ 'NOT', 'SEEN']).length

  begin
    imap.logout
    imap.disconnect
  rescue => e
    STDERR << "XXXX #{ e.inspect }"
  end

  "#{name}: #{r}"
end

