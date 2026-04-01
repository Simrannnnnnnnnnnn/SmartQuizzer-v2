# Python 3.10 slim base image
FROM python:3.10-slim

# 1. System dependencies install karo (EasyOCR aur OpenCV ke liye zaruri hain)
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# 2. HF Spaces ke liye non-root user banana ZAROORI hai
RUN useradd -m -u 1000 user
USER user
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH

# 3. Working directory set karo
WORKDIR $HOME/app

# 4. Requirements file copy karke install karo
COPY --chown=user requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 5. EasyOCR models download karo (taaki runtime par slow na ho)
RUN python -c "import easyocr; reader = easyocr.Reader(['en'])"

# 6. Baaki saara code copy karo
COPY --chown=user . .

# 7. Hugging Face ka default port expose karo
EXPOSE 7860

# 8. Gunicorn production server se run karo
CMD ["gunicorn", "-b", "0.0.0.0:7860", "main:app", "--timeout", "120"]
