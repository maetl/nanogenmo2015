require 'calyx'

SKILL = 'SKILL'

class SavingThrow < Calyx::Grammar
  start :save_against_trap, :save_against_attack
  rule :save_against_trap, 'To avoid the trap, you must {movement} {safety}. {skill_test}'
  rule :save_against_attack, 'To dodge the attack, you must {movement} {safety}. {skill_test}'
  rule :dodge, 'dodge', 'avoid'
  rule :movement, 'dive', 'roll', 'jump'
  rule :safety, 'to safety', 'clear in time'

  rule :test_of, 'Test your', 'Roll against', 'This is a test of'
  rule :skill_test, '{test_of} SKILL. {save_procedure}'
  rule :strength_test, '{test_of} STRENGTH. {save_procedure}'
  rule :stamina_test, '{test_of} STAMINA {save_procedure}'

  rule :save_procedure, "{success_procedure} {failure_procedure}\n\n"
  rule :success_procedure, 'If you succeed, you can {continue_to_the_exit}', 'If successful, then {continue_to_the_exit}', 'If your roll succeeds, {continue_to_the_exit}'
  rule :continue_to_the_exit, 'choose one of the exits.', 'choose an exit path.', 'go to one of the exits.'
  rule :failure_procedure, 'If you fail, {continue_reading}.', 'Otherwise, {continue_reading}.'
  rule :continue_reading, 'continue reading', 'continue below', 'continue', 'keep reading'
end

save = SavingThrow.new
puts save.generate
