class FormsController < ApplicationController
  def new
    @form = Form.new
  end

  def create
    @form = Form.new(form_params)

    if @form.valid?
      redirect_to new_form_path, notice: "Form submitted successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def form_params
    params.require(:form).permit(:name, :email, :message)
  end
end
