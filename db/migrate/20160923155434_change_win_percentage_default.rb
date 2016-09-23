class ChangeWinPercentageDefault < ActiveRecord::Migration[5.0]
  def change
    change_column_default :players, :win_percentage, 0
  end
end
