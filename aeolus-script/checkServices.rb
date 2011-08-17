#!/usr/bin/ruby
init_scripts=%w(aeolus-conductor aeolus-connector condor conductor-dbomatic conductor-delayed_job  deltacloud-ec2-us-east-1 deltacloud-ec2-us-west-1 deltacloud-mock httpd imagefactory iwhd libvirtd mongod ntpd postgresql qpidd)

init_scripts.each do |script|
	puts "\nChecking #{script} ..."
        cmd = "/etc/init.d/#{script} status"
	out = `#{cmd}`
	if $?.to_i == 0
		puts " \e[1;32mSuccess:\e[0m #{out.strip}"
	else
		puts " \e[1;31mFAILURE:\e[0m #{out.strip}"
	end
end

# Other checks
commands = [
 {:name => 'production solr', 	:command => 'lsof -i :8983'},
 {:name => 'connector',		:command => 'lsof -i :2003'},
 {:name => 'condor_q',		:command => 'condor_q'},
 {:name => 'condor_status',	:command => 'condor_status'}
]
commands.each do |cmd|
	puts "\nChecking #{cmd[:name]} ..."
	cmd = "#{cmd[:command]}"
	out = `#{cmd}`
        if $?.to_i == 0
                puts " \e[1;32mSuccess:\e[0m #{out.strip}"
        else
                puts " \e[1;31mFAILURE:\e[0m #{out.strip}"
        end
end
