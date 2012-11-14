#================
# Matrix Pages for a Portfolio Site
#================

#
class Matrices < BasePage

  frame_element

  # Clicks the Add link and instantiates
  # the AddEditMatrix Class.
  action(:add) { |b| b.frm.link(:text=>"Add").click }
  action(:import) { |b| b.frm.link(:text=>"Import").click }
  action(:manage_site_associations) { |b| b.frm.link(:text=>"Manage Site Associations").click }
  action(:permissions) { |b| b.frm.link(:text=>"Permissions").click }
  action(:my_preferences) { |b| b.frm.link(:text=>"My Preferences").click }

  # Clicks the "Edit" link for the specified
  # Matrix item, then instantiates the EditMatrixCells.
  action(:edit) { |matrixname, b| b.matrix_table.tr(:text=>/#{Regexp.escape(matrixname)}/).link(:text=>"Edit").click }

  # Clicks the "Preview" link for the specified
  # Matrix item.
  action(:preview) { |matrixname, b| b.matrix_table.tr(:text=>/#{Regexp.escape(matrixname)}/).link(:text=>"Preview").click }

  # Clicks the "Publish" link for the specified
  # Matrix item, then instantiates the ConfirmPublishMatrix Class.
  action(:publish) { |matrixname, b| b.matrix_table.tr(:text=>/#{Regexp.escape(matrixname)}/).link(:text=>"Publish").click }

  action(:delete) { |matrixname, b| b.matrix_table.tr(:text=>/#{Regexp.escape(matrixname)}/).link(:text=>"Delete").click }

  action(:export) { |matrixname, b| b.matrix_table.tr(:text=>/#{Regexp.escape(matrixname)}/).link(:text=>"Export").click }

  action(:permissions) { |matrixname, b| b.matrix_table.tr(:text=>/#{Regexp.escape(matrixname)}/).link(:text=>"Permissions").click }

  element(:matrix_table) { |b| b.frm.table(:class=>"listHier lines nolines") }

  def matrices_list
    text_array = matrix_table.to_a
    text_array.delete_at(0) # deletes the header row which is useless
    list=[]
    text_array.each do |line|
      list << line[0]
    end
    list
  end

end

#
class AddEditMatrix < BasePage

  include FCKEditor
  frame_element

  expected_element :editor

  element(:editor) { |b| b.frm.frame(:id=>"descriptionTextArea___Frame") }

  # Clicks the "Create Matrix" button
  action(:create_matrix) { |b| b.frm.button(:value=>"Create Matrix").click }

  # Clicks the "Save Changes" button
  action(:save_changes) { |b| b.frm.button(:value=>"Save Changes").click }

  # Clicks the "Select Style" link
  action(:select_style) { |b| b.frm.link(:text=>"Select Style").click }

  # Clicks the "Add Column" link
  action(:add_column) { |b| b.frm.link(:text=>"Add Column").click }

  # Clicks the "Add Row" link
  action(:add_row) { |b| b.frm.link(:text=>"Add Row").click }

  element(:title) { |b| b.frm.text_field(:id=>"title-id") }

end

#
class SelectMatrixStyle < BasePage

  frame_element

  # Clicks the "Go Back" button and
  # instantiates the AddEditMatrix Class.
  action(:go_back) { |b| b.frm.button(:value=>"Go Back").click }

  # Clicks the "Select" link for the specified
  # Style, then instantiates the AddEditMatrix Class.
  action(:select_style) { |stylename, b| b.frm.table(:class=>/listHier lines/).tr(:text=>/#{Regexp.escape(stylename)}/).link(:text=>"Select").click }

end

class RowColumnCommon < BasePage

  frame_element
  class << self
    def table_elements
      action(:update) { |b| b.frm.button(:value=>"Update").click }
      element(:name) { |b| b.frm.text_field(:name=>"description") }
      element(:background_color) { |b| b.frm.text_field(:id=>"color-id") }
      element(:font_color) { |b| b.frm.text_field(:id=>"textColor-id") }
    end
  end
end

#
class AddEditColumn < RowColumnCommon

  table_elements

end

#
class AddEditRow < RowColumnCommon

  table_elements

end

#
class EditMatrixCells < BasePage

  frame_element

  # Clicks on the cell that is specified, based on
  # the row number, then the column number.
  #
  # Note that the numbering begins in the upper left
  # of the Matrix, with (1, 1) being the first EDITABLE
  # cell, NOT the first cell in the table itself.
  #
  # In other words, ignore the header row and header column
  # in your count (or, if you prefer, consider those
  # to be numbered "0").
  action(:edit) { |row, column, b| b.frm.div(:class=>"portletBody").table(:summary=>"Matrix Scaffolding (click on a cell to edit)").tr(:index=>row).td(:index=>column-1).fire_event("onclick") }

  # Clicks the "Return to List" link and
  # instantiates the Matrices Class.
  action(:return_to_list) { |b| b.frm.link(:text=>"Return to List").click }

end

#
class EditCell < BasePage

  frame_element

  expected_element :select_evaluators_link

  element(:select_evaluators_link) { |b| b.frm.link(:text=>"Select Evaluators") }

  # Clicks the "Select Evaluators" link
  # and instantiates the SelectEvaluators Class.
  action(:select_evaluators) { |p| p.select_evaluators_link.click }

  # Clicks the Save Changes button and instantiates
  # the EditMatrixCells Class.
  action(:save_changes) { |b| b.frm.button(:value=>"Save Changes").click }

  element(:title) { |b| b.frm.text_field(:id=>"title-id") }
  element(:use_default_reflection_form) { |b| b.frm.checkbox(:id=>"defaultReflectionForm") }
  element(:reflection) { |b| b.frm.select(:id=>"reflectionDevice-id") }
  element(:use_default_feedback_form) { |b| b.frm.checkbox(:id=>"defaultFeedbackForm") }
  element(:feedback) { |b| b.frm.select(:id=>"reviewDevice-id") }
  element(:use_default_evaluation_form) { |b| b.frm.checkbox(:id=>"defaultEvaluationForm") }
  element(:evaluation) { |b| b.frm.select(:id=>"evaluationDevice-id") }
  element(:use_default_evaluators) { |b| b.frm.checkbox(:id=>"defaultEvaluators") }

end

#
class SelectEvaluators < BasePage

  frame_element

  # Clicks the "Save" button and
  # instantiates the EditCell Class.
  action(:save) { |b| b.frm.button(:value=>"Save").click }
  element(:users) { |b| b.frm.select(:id=>"mainForm:availableUsers") }
  element(:selected_users) { |b| b.frm.select(:id=>"mainForm:selectedUsers") }
  element(:roles) { |b| b.frm.select(:id=>"mainForm:audSubV11:availableRoles") }
  element(:selected_roles) { |b| b.frm.select(:id=>"mainForm:audSubV11:selectedRoles") }
  action(:add_users) { |b| b.frm.button(:id=>"mainForm:add_user_button").click }
  action(:remove_users) { |b| b.frm.button(:id=>"mainForm:remove_user_button").click }
  action(:add_roles) { |b| b.frm.button(:id=>"mainForm:audSubV11:add_role_button").click }
  action(:remove_roles) { |b| b.frm.button(:id=>"mainForm:audSubV11:remove_role_button").click }

end

#
class ConfirmPublishMatrix < BasePage

  frame_element

  # Clicks the "Continue" button and
  # instantiates the Matrices Class.
  action(:continue) { |b| b.frm.button(:value=>"Continue").click }

end