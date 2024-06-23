CREATE TABLE IF NOT EXISTS public.input_invoices
(
    invoice_id character varying COLLATE pg_catalog."default" NOT NULL,
    json_data json,
    pdf_file bytea,
    CONSTRAINT input_invoices_pkey PRIMARY KEY (invoice_id)
);

ALTER TABLE IF EXISTS public.input_invoices
    OWNER to postgres;
