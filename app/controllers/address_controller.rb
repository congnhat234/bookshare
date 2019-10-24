class AddressController < ApplicationController
  def load_districts
    @districts = District.where(province_id: params[:selected_province])
    @districts = @districts.map{|district| [district.name, district.id]}
    render json: {districts: @districts}
  end

  def load_wards
    @wards = Ward.where(district_id: params[:selected_district])
    @wards = @wards.map{|ward| [ward.name, ward.id]}
    render json: {wards: @wards}
  end
end
