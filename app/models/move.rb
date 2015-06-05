# == Schema Information
#
# Table name: moves
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  row        :integer
#  column     :integer
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Move < ActiveRecord::Base
  belongs_to :player
  validates :row, :column, :token, presence: true
  validate :uniq_coordinates

  private

  def uniq_coordinates
    duplicate = player.game.moves.find_by(row: row, column: column)
    errors.add(:base, 'Duplicate') if duplicate
  end
end
