class Admin::RolesGroupsController < Admin::BaseController
  load_resource

  def index
    @roles_groups.includes(:roles_models)
  end

  def show
  end

  def new
  end

  def create
    if @roles_group.save
      ActiveRecord::Base.transaction do
        params["model_class_name"].each do |model_class_name|
          if params["#{model_class_name}_roles"].present?
            RolesModel.create(
              code: BindRolesModelService.new(model_class_name.humanize.constantize)
                .generate_code(params["#{model_class_name}_roles"]),
              model_class_name: model_class_name.humanize,
              roles_group_id: @roles_group.id
              )
          end
        end
      end
      redirect_to [:admin, :roles_groups]
    else
      flash[:danger] = t ".errors"
      redirect_to new_admin_roles_group_url
    end

  end

  private
  def roles_group_params
    params.require(:roles_group).permit :name
  end
end
