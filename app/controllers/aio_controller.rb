class AioController < ApplicationController
  before_action :set_user, except: :login

  def login
    email = params.require(:email)

    @user = User.find_by(email: email)

    if @user.blank?
      @user = User.new(email: email)

      if @user.valid?
        User.transaction do
          @user.save!
          @user.create_wallet!
        end
      else
        render json: { error: @user.errors }, status: 400

        return
      end
    end

    session[:user_id] = @user.id

    render json: @user
  end

  def wallet
    render json: @user.wallet.serializable_hash(methods: :balance, include: {credits: {}, debits: {}})
  end

  def deposit
    amount = params.require(:amount)

    @transaction = Transaction.new
    @transaction.amount = amount.to_f
    @transaction.target_wallet_id = @user.wallet.id

    if @transaction.valid?
      @transaction.save!

      render json: @transaction.serializable_hash(include: {target_wallet: {methods: :balance}})
    else
      render json: { error: @transaction.errors }, status: 400
    end
  end

  def withdraw
    amount = params.require(:amount)

    @transaction = Transaction.new
    @transaction.amount = amount.to_f
    @transaction.source_wallet_id = @user.wallet.id

    if @transaction.valid?
      @transaction.save!

      render json: @transaction.serializable_hash(include: {source_wallet: {methods: :balance}})
    else
      render json: { error: @transaction.errors }, status: 400
    end
  end

  def transfer
    amount, target_wallet_id = params.require([:amount, :target_wallet_id])

    @transaction = Transaction.new
    @transaction.amount = amount.to_f
    @transaction.source_wallet_id = @user.wallet.id
    @transaction.target_wallet_id = target_wallet_id.to_i

    if @transaction.valid?
      @transaction.save!

      render json: @transaction.serializable_hash(include: {source_wallet: {methods: :balance}})
    else
      render json: { error: @transaction.errors }, status: 400
    end
  end

  private

  def set_user
    @user = User.find(session[:user_id])
  end
end
