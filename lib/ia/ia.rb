# encoding: utf-8

require 'set'

require_relative 'ia_stage_a'
require_relative 'ia_stage_b'
require_relative 'ia_stage_c'
require_relative 'ia_stage_d'
require_relative 'ia_stage_e'

require_relative 'ia_calculate'

module IA
  include IA_stage_a
  include IA_stage_b
  include IA_stage_c
  include IA_stage_d
  include IA_stage_e

  include IA_calculate
end
