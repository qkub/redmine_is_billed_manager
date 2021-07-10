Redmine::Plugin.register :time_track_is_billed_manager do
  name 'Time Track Is Billed Manager plugin'
  author 'Bostjan Kukovec'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://rmine.heartcode.si/isbilledmanager'
  author_url 'http://github.com/qkub'


  menu :account_menu  , :isbilledmanager,
       { controller: 'isbilledmanager', action: 'index' },
       caption: 'IsBilledUpdate',
       after: :work_time,
       if: Proc.new { User.current && User.current.admin }


end
