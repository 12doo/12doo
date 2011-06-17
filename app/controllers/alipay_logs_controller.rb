# -*- encoding : utf-8 -*-
class AlipayLogsController < ApplicationController
  before_filter :authorize_admin!
  # GET /alipay_logs
  # GET /alipay_logs.xml
  def index
    @alipay_logs = AlipayLog.order("id desc").page(params[:page])
  end

  # GET /alipay_logs/1
  # GET /alipay_logs/1.xml
  def show
    @alipay_log = AlipayLog.find(params[:id])
  end
end
