class AppointmentsController < ApplicationController
  before_action :set_doctor

  def index
    @regulars = @doctor.appointments.where(role: 'regular')
    @new_client = @doctor.appointments.where(role: 'new')
  end

  def new
    @appointment = @doctor.appointments.new
  end

  def create
    @appointment = @doctor.appointment.new(appointment_params)
    if @appointment.save
      redirect_to doctor_appointments_path(@doctor)
    else
      render :new
    end
  end

  def destroy
    @appointment.destroy
    redirect_to doctor_appointments_path(@doctor)
  end

  private

  def set_doctor
    @doctor = Doctor.find(params[:doctor_id])
  end

  def appointment_params
    params.require(:appointment).permit(:role, :user_id)
  end
end
