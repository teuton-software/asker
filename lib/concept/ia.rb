# encoding: utf-8

require 'set'

require_relative 'ia_stage_a'
require_relative 'ia_stage_b'
require_relative 'ia_stage_c'
require_relative 'ia_stage_d'

require_relative 'ia_calculate'
require_relative 'ia_sequence'
require_relative 'ia_texts'

module IA
  include IA_stage_a
  include IA_stage_b
  include IA_stage_c
  include IA_stage_d

  include IA_calculate
  include IA_sequence
  include IA_texts
end
