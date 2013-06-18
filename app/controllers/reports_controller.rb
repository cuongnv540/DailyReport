class ReportsController < ApplicationController
 before_filter :signed_in_user, only: [:index, :new]
 before_filter :manager_check, only: [:manager_report]
 	

 	def manager_report
 		@user = User.find_by_sql("select *from users where group_id=#{current_user.group_id} ") 
 		# So sanh phai dung "== khong dc dung "="
 		# Dung = se gan gia tri luon chu khong phai so sanh
 		if params[:choose] == "1"
 			@time = 1
 		elsif params[:choose] == "2"
 			@time = 7
 		elsif params[:choose] == "3"
 			@time = 30
 		else
 			@time = 0
 		end
 	end

 	def search
	 		@search = Report.search(params[:q])
	    	@reports = @search.result(:distinct => true)	

 	end

 	def report_results
 		@search = Report.search(params[:tim])
    	@reports = @search.result(:distinct => true )
 		respond_to do |format|
	    	format.html
	 		format.csv { send_data @reports.to_csv }
    		format.xls   
    	end
 	end


 	def report_all
 		respond_to do |format|
	    	format.html
	 		format.csv { send_data @reports.to_csv }
    		format.xls   	
	  	end
 	end

 	def report_member
	 	respond_to do |format|
	    	format.html
	 		format.csv { send_data @reports.to_csv }
    		format.xls   	
	  	end
 	end

 	def edit
    	@report = Report.find(params[:id])
  	end

  	def update
  	end

 	def destroy
    @report = Report.find(params[:id])
    @report.destroy
    redirect_to reports_path
  	end

	def new 
		@report = Report.new
		@catalogs = Catalog.all 
	end

	def create
		@report = Report.new(params[:report])
		if params[:upload].present?
			name = params[:upload][:datafile].original_filename
			directory = 'public/data'
			path = File.join(directory,name)
	    	File.open(path, "wb") { |f| f.write(params[:upload][:datafile].read)}
	    	@report.file_name = name
	    	@report.file_path = path	
		end
	    @report.user_id = current_user.id
	    if @report.save
	    	flash[:success] = "Report upload success !"
	    	redirect_to reports_path
	    else
	    	render 'new'
	    end
	end

	def index
		@reports= Report.find_by_sql("select *from reports where user_id=#{current_user.id} ")
	end

	private

	def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def manager_check
    	if current_user.manager?
    	else
    		redirect_to root_path, notice: "You don't have permission!"
    	end
    end

end
