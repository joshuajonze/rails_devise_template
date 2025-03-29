module PolicyHelper
    def policy_check(record, action)
      if policy(record).public_send(action)
        yield if block_given?
        true
      else
        false
      end
    end
  end