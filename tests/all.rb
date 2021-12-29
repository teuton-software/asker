#!/usr/bin/env ruby

require 'minitest/autorun'

require_relative 'application_test'
require_relative 'input_checker_test'
require_relative 'project_data_test'

require_relative 'ai/code/code_ai_factory_test'
require_relative 'ai/question_test'
require_relative 'ai/concept_ai_test'
require_relative 'ai/stages/base_stage_test'


require_relative 'data/code_test'
require_relative 'data/world_test'
require_relative 'data/concept_test'
require_relative 'data/column_test'
require_relative 'data/data_field_test'
require_relative 'data/table_test'
require_relative 'data/template_test'
require_relative 'data/row_test'

require_relative 'formatter/concept_string_formatter_test'
require_relative 'formatter/question_gift_formatter_test'

require_relative 'lang/lang_test'
require_relative 'lang/lang_factory_test'

#require_relative 'loader/image_url_loader_test'
require_relative 'loader/file_loader_test'
require_relative 'loader/directory_loader_test'
require_relative 'loader/input_loader_test'
require_relative 'loader/project_loader_test'

#require_relative 'rubocop_test'
