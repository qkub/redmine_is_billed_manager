class IsBilledMarkEntry < ActiveRecord::Base
  after_save {id = self.id}
end
