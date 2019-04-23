# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(authentication_id: 'asadaafaf', nickname: 'SkataBoy',
              wechat_id: 'Sevan', gender: 'M', avatar: '', city: 'Chengdu',
              country: 'China', language: 'English')
User.create(authentication_id: 'asadsdsd', nickname: 'CoolMi',
              wechat_id: 'Mira', gender: 'F', avatar: '', city: 'Chengdu',
              country: 'China', language: 'French')
User.create(authentication_id: 'asafsfku', nickname: 'ZoZo',
              wechat_id: 'Chinzo', gender: 'M', avatar: '', city: 'Ulaanbaatar',
              country: 'Mongolia', language: 'Mongolian')
User.create(authentication_id: 'asadaafaf', nickname: 'Babyflash',
              wechat_id: 'Dave', gender: 'M', avatar: '', city: 'Edinburgh',
              country: 'Scotland', language: 'English')
