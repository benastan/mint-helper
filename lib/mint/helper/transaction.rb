module Mint
  module Helper
    class Transaction < Sequel::Model
      def net_amount
        transaction_type == 'credit' ? 0 - amount : amount
      end

      dataset_module do
        def total_debits
          where(transaction_type: 'debit').sum(:amount) || BigDecimal.new('0')
        end

        def total_credits
          where(transaction_type: 'credit').sum(:amount) || BigDecimal.new('0')
        end

        def net_spending
          total_debits - total_credits
        end

        def for_current_month
          where('date >= ? AND date <= ?', Time.new.beginning_of_month, Time.new)
        end

        def for_current_week
          where('date >= ? AND date <= ?', Time.new.utc.beginning_of_day.beginning_of_week, Time.new)
        end
        
        def for_current_month_without_current_week
          where('date >= ? AND date < ?', Time.new.beginning_of_month, Time.new.beginning_of_week)
        end

        def for_day(date)
          where('date = ?', date)
        end
        
        def not_for_day(date)
          where('date != ?', date)
        end
        
        def uncategorized
          transactions.where(category: 'Uncategorized')
        end
      end
    end
  end
end