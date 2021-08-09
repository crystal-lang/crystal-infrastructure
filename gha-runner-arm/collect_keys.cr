# Github usernames of people that should have access to this machine

ADMINS = %w(beta-ziliani jhass straight-shoota)
DIR    = "files"

require "http/client"

Dir.mkdir_p(DIR)

authorized_keys = DIR + "/authorized_keys"

File.open(authorized_keys, "w") do |io|
  ADMINS.each do |user|
    io.puts "# #{user}"
    io.puts HTTP::Client.get("https://github.com/#{user}.keys").body
  end
end

cloud_init = DIR + "/cloud-init/user-data.j2"

Dir.mkdir_p(File.dirname(cloud_init))

ssh_keys = File.read(authorized_keys).lines.map { |line| "  - #{line}" unless line.starts_with?('#') }.compact.join("\n")

File.write cloud_init, <<-USER
  #cloud-config
  user: crystal
  password: changeme
  chpasswd: { expire: False }
  ssh_pwauth: False
  hostname: {{item}}
  ssh_authorized_keys:
  #{ssh_keys}
  USER

puts "All public keys written to #{authorized_keys} and #{cloud_init}"
