##### LICENSE

# Copyright (c) Skyscrapers (iLibris bvba) 2015 - http://skyscrape.rs
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# == Class solr::repo
#
# This class is called from solr
#
class solr::repo {
  if !defined(Class['apt']) {
    class { 'apt': }
  }
  if ($::lsbdistrelease == '14.04') {
    apt::source { 'trusty-solrjetty':
      location    => 'http://repo.int.skyscrape.rs/',
      release     => 'trusty-solrjetty',
      repos       => 'main',
      key         => '0407B13E',
      include_src => false,
    }
  }
}
