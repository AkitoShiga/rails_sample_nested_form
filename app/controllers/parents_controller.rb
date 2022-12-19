class ParentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @parents = Parent.all
  end

  def show
    @parent = Parent.find(params[:id])
  end

  def new
    @parent_form = Forms::ParentForm.new
  end

  def create
    @parent_form = Forms::ParentForm.new(parent_form_params)
    @child_forms = @parent_form.child_forms

    unless[@parent_form, *@child_forms].map(&:valid?).all?
      return render({ action: :new, status: :unprocessable_entity }, notice: '登録できませんでした')
    end

    parent = @parent_form.to_parent
    parent.save!

    redirect_to action: :show, id: parent.id
  end

  def destroy
    parent = Parent.find(params[:id])
    parent.destroy!

    redirect_to action: :index
  end

  private

  def parent_form_params
    params.require(:forms_parent_form).permit(:name, child_forms_attributes: [:name, :birthday])
  end
end
