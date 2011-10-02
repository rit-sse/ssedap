class DirectoryUsersController < ApplicationController
  # GET /directory_users
  # GET /directory_users.json
  def index
    @directory_users = DirectoryUser.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @directory_users }
    end
  end

  # GET /directory_users/1
  # GET /directory_users/1.json
  def show
    @directory_user = DirectoryUser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @directory_user }
    end
  end

  # GET /directory_users/new
  # GET /directory_users/new.json
  def new
    @directory_user = DirectoryUser.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @directory_user }
    end
  end

  # GET /directory_users/1/edit
  def edit
    @directory_user = DirectoryUser.find(params[:id])
  end

  # POST /directory_users
  # POST /directory_users.json
  def create
    @directory_user = DirectoryUser.new(params[:directory_user])

    respond_to do |format|
      if @directory_user.save
        format.html { redirect_to @directory_user, notice: 'Directory user was successfully created.' }
        format.json { render json: @directory_user, status: :created, location: @directory_user }
      else
        format.html { render action: "new" }
        format.json { render json: @directory_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /directory_users/1
  # PUT /directory_users/1.json
  def update
    @directory_user = DirectoryUser.find(params[:id])

    respond_to do |format|
      if @directory_user.update_attributes(params[:directory_user])
        format.html { redirect_to @directory_user, notice: 'Directory user was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @directory_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /directory_users/1
  # DELETE /directory_users/1.json
  def destroy
    @directory_user = DirectoryUser.find(params[:id])
    @directory_user.destroy

    respond_to do |format|
      format.html { redirect_to directory_users_url }
      format.json { head :ok }
    end
  end
end
