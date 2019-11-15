class OrganizationTransactionsController < ApplicationController
  include Sortable

  before_action :authenticate_user!
  before_action :authenticate_administrator!, except: [:index, :show]
  before_action :set_organization
  before_action :set_organization_transaction, only: [:show, :edit, :update, :destroy]

  def index
    organization_transactions = @organization.organization_transactions.order(order_by)
    @pagy, @organization_transactions = pagy(organization_transactions)

    respond_to do |format|
      format.html
      format.csv do
        send_data(
          @organization.organization_transactions_csv,
          filename: "organization-transactions-#{@organization.id}.csv"
        )
      end
    end
  end

  def new
    @organization_transaction = @organization.organization_transactions.build(posted_at: Date.current)
  end

  def create
    @organization_transaction = @organization.organization_transactions.build(organization_transaction_params)

    respond_to do |format|
      ActiveRecord::Base.transaction do
        @organization_transaction.save!
        @organization.recalculate_balance!
      end
      format.html { redirect_to organization_transaction_path(@organization, @organization_transaction), notice: "Transaction was successfully created." }
      format.json { render :show, status: :created, location: organization_transaction_path(@organization, @organization_transaction) }
    rescue => e
      Rollbar.error e
      format.html { render :new }
      format.json { render json: @organization_transaction.errors, status: :unprocessable_entity }
    end
  end

  def update
    respond_to do |format|
      ActiveRecord::Base.transaction do
        @organization_transaction.update! organization_transaction_params
        @organization.recalculate_balance!
      end
      format.html { redirect_to organization_transaction_path(@organization, @organization_transaction), notice: "Transaction was successfully updated." }
      format.json { render :show, status: :ok, location: organization_transaction_path(@organization, @organization_transaction) }
    rescue => e
      Rollbar.error e
      format.html { render :edit }
      format.json { render json: @organization_transaction.errors, status: :unprocessable_entity }
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      @organization_transaction.destroy
      @organization.recalculate_balance!
    end
    respond_to do |format|
      format.html { redirect_to organization_transactions_path(@organization), notice: "Transaction was successfully destroyed." }
      format.json { head :no_content }
    end
  rescue => e
    Rollbar.error e
  end

  private

  def set_organization
    @organization = Current.organization
  end

  def set_organization_transaction
    @organization_transaction = @organization.organization_transactions.find(params[:id])
  end

  def organization_transaction_params
    params.require(:organization_transaction)
      .permit(
        :amount,
        :description,
        :gift,
        :reference,
        :transaction_type
      ).tap do |whitelisted|
        whitelisted[:posted_at] = Date.strptime(params[:organization_transaction][:posted_at], "%m/%d/%Y")
      end
  end

  def sort_column
    return params[:column] if sortable_columns.include?(params[:column])
    "posted_at"
  end

  def sortable_columns
    %w[
      posted_at
      amount_cents
    ]
  end
end
