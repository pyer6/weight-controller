class GraphsController < ApplicationController
  def index
    # GraphはClassメソッド
    gon.weight_records = Graph.chart_data(current_user)
    # 記録済みの日付データ
    gon.recorded_dates = current_user.graphs.map(&:date)
  end
  
  def create
    # binding.pry
    
    @graph = current_user.graphs.build(graph_params)
    date = @graph.date.strftime('%Y/%-m/%-d')
    if @graph.save
      flash[:notice] = "#{date}の記録を追加しました"
    else
      flash[:alert] = 'エラーが発生しました'
    end
    redirect_to root_path
  end
  
  def update
    @graph = current_user.graphs.find_by(date: params[:graph][:date])
    # binding.pry
    date = @graph.date.strftime('%Y/%-m/%-d')
    if @graph.nil?
      flash[:alert] = 'エラーが発生しました'
    elsif params[:_destroy].nil? && @graph.update(graph_params)
      flash[:notice] = "#{date}の記録を修正しました。"
    elsif params[:_destroy].present? && @graph.destroy
      flash[:alert] = "#{date}の記録を削除しました。"
    else
      flash[:alert] = 'エラーが発生しました'
    end
    redirect_to root_path
  end
  
  private
  
  def graph_params
    params.require(:graph).permit(:date, :weight)
  end
end