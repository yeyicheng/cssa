class CategoriesController < ApplicationController
	before_filter :admin_auth, :only => [:edit, :new, :create, :update, :destroy]
	
	# GET /categories
	# GET /categories.json
	def index
		@categories = Category.paginate(:page => params[:category_page], :per_page => 10)
		@title = 'Clubs | category'
		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @categories }
		end
	end

	# GET /categories/1
	# GET /categories/1.json
	def show
		@category = Category.find(params[:id])
		@title = 'Clubs | ' + @category[:name]
		@clubs = Organization.where(:category_id => params[:id]).order('name ASC').paginate(:page => params[:organization_page], :per_page => 15)
		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @category.to_json(:include => [:clubs]) }
		end
	end

	# GET /categories/new
	# GET /categories/new.json
	def new
		@category = Category.new
		@user = current_user
		@title = 'Category | New'
		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @category }
		end
	end

	# GET /categories/1/edit
	def edit
		@user = current_user
		@category = Category.find(params[:id])
		@title = 'Category | ' + @category[:name] + ' | Edit'
	end

	# POST /categories
	# POST /categories.json
	def create
		@user = current_user
		@category = Category.new(params[:category])
		respond_to do |format|
			if @category.save
				format.html { redirect_to @category, notice: 'Category was successfully created.' }
				format.json { render json: @category, status: :created, location: @category }
			else
				format.html { render action: "new" }
				format.json { render json: @category.errors, status: :unprocessable_entity }
			end
		end
	end

	# PUT /categories/1
	# PUT /categories/1.json
	def update
		@user = current_user
		@category = Category.find(params[:id])
		respond_to do |format|
			if @category.update_attributes(params[:category])
				format.html { redirect_to @category, notice: 'Category was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @category.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /categories/1
	# DELETE /categories/1.json
	def destroy
		@user = current_user
		@category = Category.find(params[:id])
		@category.destroy
		respond_to do |format|
			format.html { redirect_to categories_url }
			format.json { head :no_content }
		end
	end
  
	def clubs
		respond_to do |format|
			format.html { render :show }
			format.json { render json: @category.to_json(:include => [:clubs]) }
		end
	end
end
