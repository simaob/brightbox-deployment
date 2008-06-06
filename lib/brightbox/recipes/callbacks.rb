#    Brightbox - Easy Ruby Web Application Deployment
#    Copyright (C) 2008, Neil Wilson, Brightbox Systems
#
#    This file is part of the Brightbox deployment system
#
#    Brightbox gem is free software: you can redistribute it and/or modify it
#    under the terms of the GNU Affero General Public License as published
#    by the Free Software Foundation, either version 3 of the License,
#    or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#    Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General
#    Public License along with this program.  If not, see
#    <http://www.gnu.org/licenses/>.
#
# Hook tasks into the standard deployment system

after "deploy:setup",
  "configure:logrotation",
  "configure:monit",
  "configure:mongrel",
  "configure:apache",
  "configure:nginx"

after "deploy:cold",
  "deploy:monit:reload"

after "deploy:update_code",
  "gems:install"

before "deploy:migrate",
  "db:check:config",
  "db:create"

after "deploy:start",
  "deploy:web:reload_if_new"

after "deploy:restart",
  "deploy:web:reload_if_new"
